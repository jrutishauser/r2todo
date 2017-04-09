const initialState = {
  fetching: false,
  fetched: false,
  error: null,
  data: []
}
export function todoView(state = initialState, action){
  switch (action.type){
    default: return state;
    case "GET_TODOS_PENDING":
      return {
        ...state,
        fetching: true,
        fetched: false,
        error: null,
        data: []
    }
    case "GET_TODOS_FULFILLED":
      return {
        ...state,
        fetching: false,
        fetched: true,
        error: null,
        data: action.payload
    }
    case "GET_TODOS_REJECTED":
      return {
        ...state,
        fetching: false,
        fetched: true,
        error: action.payload,
        data: []
    }
  }
}
