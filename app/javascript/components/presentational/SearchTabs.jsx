import React from "react";
import { NavLink } from "react-router-dom";

import CategoryConstants from '../../constants/CategoryConstants';

const SearchTabs = ({
  activeTab, updateTabs
}) => {
  return (
    <div className="search-tabs">
      {
        Object.values(CategoryConstants).map((category, i) => {
          const {name, uri} = category;
          return (
            <NavLink
              className={activeTab === name ? "active-tab" : "search-tab"}
              onClick={(name) => updateTabs(name)}
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

