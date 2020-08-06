import axios from 'axios'

import ActionConstants from "../constants/ActionConstants";

export const fetchSearchResultsAction = (dispatch) => {
  return (params) => {
    const {pageNumber, category, query} = params;
    const request = axios.get(`search/${category}?query=${query}?page=${pageNumber}`);
    return request.then(
      success => {
        dispatch({type: ActionConstants.FETCH_SEARCH_RESULTS_ACTION, payload: {
          results: success?.data?.results, category: category
          }
        })
        return success;
      }, error => {
        return error; // TODO: ADD ERROR HANDLING IF YOU WANT
      }
    )
  };
}