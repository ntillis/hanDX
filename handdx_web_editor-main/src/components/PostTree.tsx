import * as React from 'react'

//Displays trees
type Props = {
  decisionTree: IDecisionTree
}

const DecisionTree: React.FC<Props> = ({ decisionTree }) => {
  return (
    <div className='Card'>
      <div className='Card--body'>
        <div className='Card--body-title'>{decisionTree.shortTreeName}</div>
        <p className='Card--body-text'>{decisionTree.treeDescription}</p>
      </div>
      
    </div>
  )
}
export default DecisionTree