import React, { useState,
    useEffect,
    useCallback
 } from 'react';
import ReactFlow, {
  MiniMap,
  Controls,
  Background,
  addEdge,
  ReactFlowProvider
} from 'reactflow';
import 'reactflow/dist/style.css';
import { getFirestore, doc, getDoc, collection, query, where, getDocs } from 'firebase/firestore';
import app from './firebaseConfig';

const db = getFirestore(app);

async function fetchNode(nodeId, nodesCollectionRef, accumulatedEdges = [], accumulatedNodes = [], height, xPos) {
  console.log("path: " + nodesCollectionRef.path);
  console.log("nodeId: " + nodeId);

  const nodeRef = doc(db, `${nodesCollectionRef.path}/${nodeId}`);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return { node: null, edges: accumulatedEdges, nodes: accumulatedNodes };
  }

  const vSpacing = height * 200; // Control vertical spacing of nodes

  //Get data of current node, populate node fields with it
  const nodeData = nodeSnap.data();
  const reactFlowNode = {
    id: nodeId,
    data: { label: nodeData.question || nodeData.result },
    position: { x: xPos/*Math.random() * window.innerWidth*/, y: vSpacing },
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = accumulatedEdges; // Use the accumulatedEdges passed to the function
  let nodes = accumulatedNodes; // Use the accumulatedNodes passed to the function

  nodes.push(reactFlowNode);

  if (nodeData.children) {
    //debug print stmts
    //console.log("Node: " + nodeData.question || nodeData.result);
    //console.log("NUM OF CHILDREN: " + nodeData.children.length);

    //if node has >2 children, give enough spacing for grandchildren nodes
    let extendedWidth = (nodeData.children.length > 2);
    let childX = xPos - (200 * ((nodeData.children.length / 2) * extendedWidth + 1));  // Control horizontal spacing of nodes
    for (const child of nodeData.children) {
      //debug print stmts
      //console.log("about to call fetchNode with child.nodeId: " + child.nodeId);
      //console.log("spacing: " + vSpacing + " of node: " + child.nodeId);
      
      // Pass the current edges to accumulate further
      const childResult = await fetchNode(child.nodeId, nodesCollectionRef, edges, nodes, height + 1, childX);
      if (childResult.node) {
        // Add edge for current node to child node for each child node
        edges.push({ id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text });
      }
      childX += 200 + 200*extendedWidth;  //if extended, double the spacing
    }
  }

  return { node: reactFlowNode, edges: edges , nodes: nodes};
}

const DecisionTree = ({ docId }) => {
  
  const [nodes, setNodes] = useState([]);
  const [edges, setEdges] = useState([]);
  
  useEffect(() => {
    //  async to get tree data
    const loadDecisionTree = async (decisionTreeDocId) => {
      
      const treeDocRef = doc(db, "decisionTrees", decisionTreeDocId);
      const treeDocSnap = await getDoc(treeDocRef);

      if (!treeDocSnap.exists()) {
        console.error(`No decision tree found with ID ${decisionTreeDocId}`);
        return;
      }

      const treeData = treeDocSnap.data();
      const nodesCollectionRef = collection(treeDocRef, "nodes");
      const fetchResult = await fetchNode(treeData.rootNode, nodesCollectionRef, [], [], 0, 0);

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

  const onLoad = (reactFlowInstance) => {
    reactFlowInstance.fitView();
  }
  const onConnect = useCallback((params) => setEdges((els) => addEdge(params, els)), []);
  // Render the decision tree with React Flow
  return (
    <div style={{ width: '100vw', height: '100vh' }}>
        <ReactFlowProvider>
            <ReactFlow
              onLoad={onLoad}
              nodes={nodes}
              edges={edges}
              onConnect={onConnect}
              fitView
              onNodeDoubleClick={(event, node) => handleNodeUpdate(node.id, {/* newData */})}
            >
              <Controls/>
              <MiniMap/>
              <Background variant="dots" gap={12} size={1} />
              {/* Additional UI for adding or editing nodes could go here */}
        </ReactFlow>
      </ReactFlowProvider>
    </div>
  );
};

export default DecisionTree;