class Node {
  constructor({parentId, payload}) {
    this.parentId = parentId
    this.payload = payload
  }

  getParentId() {
    return this.parentId
  }

  getPayload() {
    return this.payload
  }
}