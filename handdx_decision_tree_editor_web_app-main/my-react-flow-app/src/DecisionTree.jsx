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
  // Useful console log stmts that may help with debugging:
  console.log("path: " + nodesCollectionRef.path);
  console.log("nodeId: " + nodeId);

  // Get data of current node
  const nodeRef = doc(db, `${nodesCollectionRef.path}/${nodeId}`);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return { node: null, edges: accumulatedEdges, nodes: accumulatedNodes };
  }

  const vSpacing = height * 200; // Control vertical spacing of nodes w/ this hardcoded int

  //Get data of current node, populate our node object fields with it
  const nodeData = nodeSnap.data();
  const reactFlowNode = {
    id: nodeId,
    data: { label: nodeData.question || nodeData.result },
    position: { x: xPos, y: vSpacing },
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = accumulatedEdges; // Reference the accumulatedEdges passed to the function
  let nodes = accumulatedNodes; // Reference the accumulatedNodes passed to the function

  nodes.push(reactFlowNode);

  if (nodeData.children) {
    // Debug print stmts no longer in use but may be helpful:
    //console.log("Node: " + nodeData.question || nodeData.result);
    //console.log("NUM OF CHILDREN: " + nodeData.children.length);

    //if node has >2 children, give enough spacing for grandchildren nodes
    let extendedWidth = (nodeData.children.length > 2); // Doubles spacing of parent node if children > 2 (value = 1 if true)
    
    // Control horizontal spacing of nodes w/ harcoded int (200):
    let childX = xPos - (200 * ((nodeData.children.length / 2) * extendedWidth + 1));  
    
    for (const child of nodeData.children) {
      // Debug print stmts no longer in use but may be helpful:
      //console.log("about to call fetchNode with child.nodeId: " + child.nodeId);
      //console.log("spacing: " + vSpacing + " of node: " + child.nodeId);
      
      // Pass the current edges to accumulate further, incrementing height
      const childResult = await fetchNode(child.nodeId, nodesCollectionRef, edges, nodes, height + 1, childX);
      if (childResult.node) {
        // Add edge between current node and each child node
        edges.push({ id: `e${nodeId}-${child.nodeId}`, source: nodeId, target: child.nodeId, label: child.text });
      }
      // For each subsequent child, x position shifts right by 200 (or more if width is extended for grandchildren)
      childX += 200 + 200*extendedWidth;  //if extendedWidth == true, add extra 200 to spacing
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
      
      // Get initial root node data
      const treeDocRef = doc(db, "decisionTrees", decisionTreeDocId);
      const treeDocSnap = await getDoc(treeDocRef);

      // Catch null data error
      if (!treeDocSnap.exists()) {
        console.error(`No decision tree found with ID ${decisionTreeDocId}`);
        return;
      }

      // Obtain data from object
      const treeData = treeDocSnap.data();
      const nodesCollectionRef = collection(treeDocRef, "nodes");
      const fetchResult = await fetchNode(treeData.rootNode, nodesCollectionRef, [], [], 0, 0);

      // Use resultant node/edge collections to set ReactFlow elements
      setNodes(fetchResult.nodes);
      setEdges(fetchResult.edges);
    };
    
    loadDecisionTree(docId); // Use the actual decision tree document ID
  }, []);

  // Function to handle node updates
  const handleNodeUpdate = (nodeId, newData) => {
    updateNode(nodeId, newData);
    // TODO: Update local state
  };

  const onLoad = (reactFlowInstance) => {
    reactFlowInstance.fitView();
  }

  const onConnect = useCallback((params) => setEdges((els) => addEdge(params, els)), []);

  // TODO: Implement a function that saves the decision tree data (nodes and edges) back into Firebase

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
              /*TODO: implement this double click event, and the function it should execute*/
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