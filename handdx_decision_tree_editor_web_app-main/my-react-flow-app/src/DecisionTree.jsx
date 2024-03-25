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

// Function to fetch data
async function fetchNodeOLD(nodeId, nodesCollectionRef, accumulatedEdges = []) {
  console.log("path: " + nodesCollectionRef.path);  //Debug
  console.log("nodeId: " + nodeId);
  const nodeRef = doc(db, `${nodesCollectionRef.path}/${nodeId}`);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return null;
  }

  const nodeData = nodeSnap.data();
  //console.log("nodeData: " + nodeData);
  const reactFlowNode = {
    id: nodeId,
    data: { label: nodeData.text || `Node ${nodeId}` },
    position: { x: Math.random() * window.innerWidth, y: Math.random() * window.innerHeight }, // Random positioning, consider a better approach
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = [...accumulatedEdges];
  if (nodeData.children) {
    for (const child of nodeData.children) {
      console.log("about to call fetchNode with child.nodeId: " + child.nodeId);
      const childNode = await fetchNode(child.nodeId, nodesCollectionRef, edges);
      if (childNode) {
        edges.concat(childNode.edges); // Combine edges from the recursive call
        edges.push({ id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text });
      }
    }
  }

  return { node: reactFlowNode, edges: edges }; // Return the combined edges
}

async function fetchNode(nodeId, nodesCollectionRef, accumulatedEdges = []) {
  console.log("path: " + nodesCollectionRef.path);
  console.log("nodeId: " + nodeId);

  const nodeRef = doc(db, `${nodesCollectionRef.path}/${nodeId}`);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return { node: null, edges: accumulatedEdges };
  }

  const nodeData = nodeSnap.data();
  const reactFlowNode = {
    id: nodeId,
    data: { label: nodeData.text || `Node ${nodeId}` },
    position: { x: Math.random() * window.innerWidth, y: Math.random() * window.innerHeight },
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = accumulatedEdges; // Use the accumulatedEdges passed to the function

  if (nodeData.children) {
    for (const child of nodeData.children) {
      console.log("about to call fetchNode with child.nodeId: " + child.nodeId);
      // Pass the current edges to accumulate further
      const childResult = await fetchNode(child.nodeId, nodesCollectionRef, edges);
      if (childResult.node) {
        // Combine edges from this call with those accumulated from children
        edges = [...edges, ...childResult.edges, { id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text }];
      }
    }
  }

  return { node: reactFlowNode, edges: edges };
}

const DecisionTree = ({ docId }) => {
  //const [elements, setElements] = useState([]); //USE THIS CODE, OTHER IS FOR TESTING
  const [elements, setElements] = useState(simpleElements); //THIS IS FOR TESTING, DELETE ME AFTER
  //RETURN TO TEST BASIC SAMPLE DATA
  return (
    <div style={{ width: '100vw', height: '100vh' }}>
      <ReactFlowProvider>
          <ReactFlow
              elements={elements}
              fitView
              // Other props...
          />
          <Controls/>
          <MiniMap/>
          <Background variant="dots" gap={12} size={1} />
      </ReactFlowProvider>
    </div>
  );
  console.log("docId: " + docId);
  useEffect(() => {
    //  async to get tree data
    const loadDecisionTree = async (decisionTreeDocId) => {
      console.log("decisionTreeDocId: " + decisionTreeDocId);
      const treeDocRef = doc(db, "decisionTrees", decisionTreeDocId);
      const treeDocSnap = await getDoc(treeDocRef);

      if (!treeDocSnap.exists()) {
        console.error(`No decision tree found with ID ${decisionTreeDocId}`);
        return;
      }

      //const treeData = treeDocSnap.data();
      //const nodesCollectionRef = collection(treeDocRef, "nodes");
      //const { node: rootNode, edges } = await fetchNode(treeData.rootNode, nodesCollectionRef, []);
      
      //setElements([rootNode, ...edges]);
      setElements(simpleElements);
      console.log("here");
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
                elements={elements} fitView
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