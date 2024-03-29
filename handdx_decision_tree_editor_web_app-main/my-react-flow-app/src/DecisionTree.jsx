import React, { useState,
    useEffect
 } from 'react';
import ReactFlow, {
  MiniMap,
  Controls,
  Background,
  ReactFlowProvider
} from 'reactflow';
import 'reactflow/dist/style.css';
import { getFirestore, doc, getDoc, collection, query, where, getDocs } from 'firebase/firestore';
import app from './firebaseConfig';

const db = getFirestore(app);

//sample edge data for testing
const simpleElements = [
  { id: '1', type: 'input', data: { label: 'Root Node' }, position: { x: 250, y: 5 } },
  { id: '2', data: { label: 'Child Node 1' }, position: { x: 100, y: 100 } },
  { id: '3', data: { label: 'Child Node 2' }, position: { x: 400, y: 100 } },
  { id: 'e1-2', source: '1', target: '2', animated: true },
  { id: 'e1-3', source: '1', target: '3', animated: true },
];

async function fetchNode(nodeId, nodesCollectionRef, accumulatedEdges = [], accumulatedNodes = []) {
  console.log("path: " + nodesCollectionRef.path);
  console.log("nodeId: " + nodeId);

  const nodeRef = doc(db, `${nodesCollectionRef.path}/${nodeId}`);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return { node: null, edges: accumulatedEdges, nodes: accumulatedNodes };
  }

  //Get data of current node, populate node fields with it
  const nodeData = nodeSnap.data();
  const reactFlowNode = {
    id: nodeId,
    data: { label: nodeData.question || nodeData.result /*`Node ${nodeId}`*/ },
    position: { x: Math.random() * window.innerWidth, y: Math.random() * window.innerHeight },
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = accumulatedEdges; // Use the accumulatedEdges passed to the function
  let nodes = accumulatedNodes; // Use the accumulatedNodes passed to the function

  nodes.push(reactFlowNode);

  if (nodeData.children) {
    for (const child of nodeData.children) {
      console.log("about to call fetchNode with child.nodeId: " + child.nodeId);
      // Pass the current edges to accumulate further
      const childResult = await fetchNode(child.nodeId, nodesCollectionRef, edges, nodes);
      if (childResult.node) {
        // Add edge for current node to child node for each child node
        edges.push({ id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text });
        //edges = [...edges, ...childResult.edges, { id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text }];
      }
    }
  }

  return { node: reactFlowNode, edges: edges , nodes: nodes};
}

const DecisionTree = ({ docId }) => {
  const [nodes, setNodes] = useState([]);
  const [edges, setEdges] = useState([]);
  //const [elements, setElements] = useState([]); //USE THIS CODE, OTHER IS FOR TESTING
  //const [elements, setElements] = useState(simpleElements); //THIS IS FOR TESTING, DELETE ME AFTER TESTING
  console.log("docId: " + docId);
  const result = useEffect(() => {
    //  async to get tree data
    const loadDecisionTree = async (decisionTreeDocId) => {
      
      console.log("decisionTreeDocId: " + decisionTreeDocId);
      const treeDocRef = doc(db, "decisionTrees", decisionTreeDocId);
      const treeDocSnap = await getDoc(treeDocRef);

      if (!treeDocSnap.exists()) {
        console.error(`No decision tree found with ID ${decisionTreeDocId}`);
        return;
      }

      const treeData = treeDocSnap.data();
      const nodesCollectionRef = collection(treeDocRef, "nodes");
      const fetchResult = await fetchNode(treeData.rootNode, nodesCollectionRef, [], []);
      
      console.log("here");

      setNodes(fetchResult.nodes);
      setEdges(fetchResult.edges);
    };
    
    loadDecisionTree(docId); // Use the actual decision tree document ID
  }, []);


  // Function to handle node updates
  const handleNodeUpdate = (nodeId, newData) => {
    updateNode(nodeId, newData);
    // Update local state if needed
  };
  // Render the decision tree with React Flow
  return (
    <div style={{ width: '100vw', height: '100vh' }}>
        <ReactFlowProvider>
            <ReactFlow
                nodes={nodes}
                edges={edges}
                fitView
                onNodeDoubleClick={(event, node) => handleNodeUpdate(node.id, {/* newData */})}
            />
            <Controls/>
            <MiniMap/>
            <Background variant="dots" gap={12} size={1} />
            {/* Additional UI for adding or editing nodes could go here */}
      </ReactFlowProvider>
    </div>
  );
};

export default DecisionTree;