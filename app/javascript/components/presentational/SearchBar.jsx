import React from "react";

import loupe from "../../../assets/images/loupe.svg"

const SearchBar = ({
  query, updateQuery, submitQuery
}) => (
  <form className="search-form" onSubmit={submitQuery}>
    <input
      type="text"
      value={query}
      onChange={updateQuery}
      className="search-text"
    />
    <img className="search-loupe" src={loupe} alt="loupe"/>
  </form>
);

export default SearchBar;
