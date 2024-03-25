import 'reactflow/dist/style.css';
//import DecisionTree from './DecisionTree';
 
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

function Appold() {
  //UNCOMMENT THIS TO ACCESS WHAT WAS IN THE ORIGINAL DECISIONTREE CALL
  //return <DecisionTree docId="OThHOPsN1yymO9itfIlx" />;
}

const initialElements = [
  { id: '1', type: 'input', data: { label: 'Node 1' }, position: { x: 0, y: 0 } },
];

function App() {
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
}

export default App;
