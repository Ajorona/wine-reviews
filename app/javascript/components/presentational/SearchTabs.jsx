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
          return (
            <NavLink
              className={activeTab === uri ? "active-tab" : "search-tab"}
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

