import React from "react";
import { NavLink } from "react-router-dom";

import CategoryConstants from '../../constants/CategoryConstants';

const SearchTabs = ({
  activeTab
}) => {
  return (
    <div className="search-tabs">
      {
        Object.values(CategoryConstants).map((category, i) => {
          const {name, uri} = category;
          const classes = activeTab === uri ? "tab-active search-tab" : "search-tab";
          console.log("classes: ", classes);
          return (
            <NavLink
              className={classes}
              to={`/${uri}`}
            >
              {name}
            </NavLink>
          )
          }
        )
      }
    </div>
  );
};

export default SearchTabs;

