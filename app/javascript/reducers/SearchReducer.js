
import {Map, List} from 'immutable';

import CategoryConstants from "../constants/CategoryConstants";
import ActionConstants from "../constants/ActionConstants";

const initialState = Map({
  [CategoryConstants.HOME.uri]: Map({results: List([]), endOf: false}),
  [CategoryConstants.WINE.uri]: Map({results: List([]), endOf: false}),
  [CategoryConstants.WINERY.uri]: Map({results: List([]), endOf: false}),
  [CategoryConstants.TASTER.uri]: Map({results: List([]), endOf: false}),
  [CategoryConstants.VARIETY.uri]: Map({results: List([]), endOf: false})
})

export default (state = initialState, action) => {
  switch (action.type) {
    case ActionConstants.FETCH_SEARCH_RESULTS_ACTION:
      const {category, results} = action.payload;
      return state.update(category, existing => {
        existing = existing.update('results', existingResults => existingResults.concat(results));
        if(results.length < 10) {
          existing.set('endOf', true);
        }
        return existing;
      });
    default:
      return state
  }
}
