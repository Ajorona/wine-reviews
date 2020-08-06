
import {Map, List} from 'immutable';

import CategoryConstants from "../constants/CategoryConstants";
import ActionConstants from "../constants/ActionConstants";

const initialState = Map({
  [CategoryConstants.HOME.name]: Map({results: List([]), endOf: false}),
  [CategoryConstants.WINE.name]: Map({results: List([]), endOf: false}),
  [CategoryConstants.WINERY.name]: Map({results: List([]), endOf: false}),
  [CategoryConstants.TASTER.name]: Map({results: List([]), endOf: false}),
  [CategoryConstants.VARIETY.name]: Map({results: List([]), endOf: false})
})

export default (state = initialState, action) => {
  switch (action.type) {
    case ActionConstants.FETCH_SEARCH_RESULTS_ACTION:
      const {category, results} = action.payload;
      return state.update(category, existing => {
        existing = existing.concat(results)
        if(results.length < 10) {
          existing.set('endOf', true);
        }
        return existing;
      });
    default:
      return state
  }
}
