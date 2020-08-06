# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
# leetcode 314 https://leetcode.com/problems/binary-tree-vertical-order-traversal/
# binary-tree-vertical-order-traversal
'''
Examples 1:

Input: [3,9,20,null,null,15,7]

   3
  /\
 /  \
 9  20
    /\
   /  \
  15   7

Output:

[
  [9],
  [3,15],
  [20],
  [7]
]
'''
# two solutions
# bfs and dfs

class Solution:
    # solution one
    from collections import defaultdict
    from queue import deque
    def verticalOrder(self, root: TreeNode) -> List[List[int]]:
        tablecol = defaultdict(list)
        
        queue = deque()
        if root:
            queue.append((root, 0))
        
        while queue:
            tmpnode, col = queue.popleft()
            
            tablecol[col].append(tmpnode.val)
            
            if tmpnode.left: queue.append((tmpnode.left, col - 1))
            if tmpnode.right: queue.append((tmpnode.right, col + 1))
                
        return [tablecol[key] for key in sorted(tablecol.keys())]

    # solution two
        
        self.res = {}
        
        def helper(node,  col, row):
            if not node: return
            if col not in self.res:
                self.res[col] = []
            
            self.res[col].append((row, col, node.val))
            
            helper(node.left, col - 1, row + 1)
            helper(node.right, col + 1, row + 1)
            
        helper(root, 0, 0)
        res = []
        # sort using keys
        for key in sorted(self.res.keys()):
            res.append(self.res[key])
        realres = []
        # sort using lambda x[0] x[1]
        for i in res:
            i.sort(key = lambda x: (x[0], x[1]))
            realres.append([x[2] for x in i])
        return realres
        
        
