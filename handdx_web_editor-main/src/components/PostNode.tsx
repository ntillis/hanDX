import * as React from 'react'

//Displays nodes
type Props = {
  node: INode
}

const TreeNode: React.FC<Props> = ({ node }) => {
  return (
    <div className='Card'>
      <div className='Card--body'>
        <div className='Card--body-ntitle'>ID: {node.id}</div>
        <p className='Card--body-text'>{node.isResult}</p>
        <p className='Card--body-text'>Result: {node.result}</p>
      </div>
    </div>
  )
}
export default TreeNode