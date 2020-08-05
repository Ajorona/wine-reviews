import React, { Component } from "react";

import SearchBar from './presentational/SearchBar';
import SearchTabs from './presentational/SearchTabs';

import CategoryConstants from '../constants/CategoryConstants';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      query: '',
      activeTab: CategoryConstants.HOME.name
    }

    this.updateTabs = this.updateTabs.bind(this);
    this.updateQuery = this.updateQuery.bind(this);
    this.submitQuery = this.submitQuery.bind(this);
  }


  updateQuery = (e) => {
    e.preventDefault();
    return null;
  }

  submitQuery = (e) => {
    e.preventDefault();
    return null;
  }

  updateTabs = (active) => {
    this.setState({activeTab: active})
  }

  render() {
    const { query, activeTab } = this.state;

    return (
      <div className="container">
        <div className="row page-header">
          <div className="title-box">
            <h1 className="display-4 title">
              Search Wine Reviews
            </h1>
          </div>
          <div className="search-panel">
            <SearchBar
              query={query}
              activeTab={activeTab}
              updateQuery={this.updateQuery}
              submitQuery={this.submitQuery}
            />
            <SearchTabs
              updateTabs={this.updateTabs}
            />
          </div>
        </div>
        <div className="row page-body">

        </div>
      </div>
    )
  }
}

export default Home;
