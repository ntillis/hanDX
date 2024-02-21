import React, { useState,
    useEffect
 } from 'react';
import ReactFlow, {
  MiniMap,
  Controls,
  ReactFlowProvider
} from 'reactflow';
import 'reactflow/dist/style.css';
import { getFirestore, doc, getDoc } from 'firebase/firestore';
import app from './firebaseConfig';

const db = getFirestore(app);

// Function to fetch data
async function fetchTreeData(docId) {
  const docRef = doc(db, "DecisionTrees", docId);
  const docSnap = await getDoc(docRef);

  if (docSnap.exists()) {
    console.log("Document data:", docSnap.data());
    return docSnap.data();
  } else {
    console.log("No such document!");
  }
}

const DecisionTree = (docId) => {
    const [nodes, setNodes] = useState([]);
    const [edges, setEdges] = useState([]);

  useEffect(() => {
    // Fetch initial tree data from Firebase
    const loadData = async () => {
      const treeData = await fetchTreeData(docId);
      // Transform treeData into nodes and edges for React Flow
      setNodes(treeData.nodes);
      setEdges(treeData.edges);
    };
    
    loadData();
  }, []);

  // Function to handle node updates
  const handleNodeUpdate = (nodeId, newData) => {
    updateNode(nodeId, newData);
    // Update local state if needed
  };

  // Render the decision tree with React Flow
  return (
    <div style={{ height: '100vh' }}>
        <ReactFlowProvider>
            <ReactFlow
                nodes={nodes}
                edges={edges}
                onNodesChange={setNodes}
                onEdgesChange={setEdges}
                onNodeDoubleClick={(event, node) => handleNodeUpdate(node.id, {/* newData */})}
            />
            <Controls/>
            <MiniMap/>
            {/* Additional UI for adding or editing nodes could go here */}
      </ReactFlowProvider>
    </div>
  );
};

export default DecisionTree;