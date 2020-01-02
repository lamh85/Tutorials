/*

Given this graph:
https://miro.medium.com/max/1632/1*c1myQEwNTF8crkwIEmnAsg.jpeg

*/

const createEdge = (node, distance) => ({ node, distance })

const createEdgesArray = dataArray => {
  return dataArray.map((node, distance) => createEdge(node, distance))
}

const GRAPH = {
  a: {
    edges: createEdgesArray([
      ['b', 3], ['c', 2], ['e', 4]
    ])
  },
  b: {
    edges: createEdgesArray([
      ['a', 3], ['c', 8]
    ])
  },
  c: {
    edges: createEdgesArray([
      ['a', 2], ['b', 8], ['d', 1]
    ])
  },
  d: {
    edges: createEdgesArray([
      ['c', 1], ['e', 3]
    ])
  },
  e: {
    edges: createEdgesArray([
      ['a', 4], ['d', 3]
    ])
  }
}