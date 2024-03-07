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

// Function to fetch data
async function fetchNode(nodeId, nodesCollectionRef) {
  const nodeRef = doc(nodesCollectionRef, nodeId);
  const nodeSnap = await getDoc(nodeRef);

  if (!nodeSnap.exists()) {
    console.error(`No node found with ID ${nodeId}`);
    return null;
  }

  const nodeData = nodeSnap.data();
  const reactFlowNode = {
    id: nodeId,
    // Assuming nodeData contains a field 'text' for the label
    data: { label: nodeData.text || `Node ${nodeId}` },
    position: { x: Math.random() * window.innerWidth, y: Math.random() * window.innerHeight }, // Random positioning, consider a better approach
    type: nodeData.isResult ? 'output' : 'default',
  };

  let edges = [];
  if (nodeData.children) {
    for (const child of nodeData.children) {
      const childNode = await fetchNode(child.id, nodesCollectionRef);
      if (childNode) {
        edges.push({ id: `e${nodeId}-${child.id}`, source: nodeId, target: child.id, label: child.text });
      }
    }
  }

  return { node: reactFlowNode, edges };
}


const DecisionTree = (docId) => {
  const [elements, setElements] = useState([]);

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
      console.log(treeData);
      console.log(nodesCollectionRef);
      const { node: rootNode, edges } = await fetchNode(treeData.rootNode, nodesCollectionRef);

      setElements([rootNode, ...edges]);
    };

    loadDecisionTree(docId); // Use the actual decision tree document ID
  }, []);


  // Function to handle node updates
  const handleNodeUpdate = (nodeId, newData) => {
    updateNode(nodeId, newData);
    // Update local state if needed
  };
  //console.log(elements);
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