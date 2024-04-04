import 'reactflow/dist/style.css';
import DecisionTree from './DecisionTree';
import Flow from './DecisionTree';
import React, { useCallback } from 'react';
import ReactFlow, {
  Background,
  Controls,
  MiniMap,
  useNodesState,
  useEdgesState,
  addEdge,
  Position,
} from 'reactflow';

import 'reactflow/dist/base.css';

 export default function App() {
  return (
    <div className="App">
      <DecisionTree docId="OThHOPsN1yymO9itfIlx" />
    </div>
  );
}

