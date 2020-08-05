import React, { Component } from "react";

import SearchBar from './presentational/SearchBar';
import SearchTabs from './presentational/SearchTabs';

import CategoryConstants from '../constants/CategoryConstants';

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      query: '',
      activeTab: ''
    }

    this.updateQuery = this.updateQuery.bind(this);
    this.submitQuery = this.submitQuery.bind(this);
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (prevProps.location.pathname !== this.props.location.pathname) {
      this.setState({activeTab: this.props.location.pathname.substring(1)});
    }
  }

  updateQuery = (e) => {
    e.preventDefault();
    return null;
  }

  submitQuery = (e) => {
    e.preventDefault();
    return null;
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
              activeTab={activeTab}
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
