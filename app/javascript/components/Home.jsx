import React, { Component } from "react";
import { connect } from 'react-redux';
import { debounce } from 'lodash';

import SearchBar from './presentational/SearchBar';
import SearchTabs from './presentational/SearchTabs';
import ReviewList from './presentational/ReviewList';

import { fetchSearchResultsAction } from '../actions/SearchActions';

import CategoryConstants from "../constants/CategoryConstants";

class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      query: '',
      activeTab: '',
      page: {
        [`${CategoryConstants.HOME.uri}Page`]: 0,
        [`${CategoryConstants.WINE.uri}Page`]: 0,
        [`${CategoryConstants.VARIETY.uri}Page`]: 0,
        [`${CategoryConstants.TASTER.uri}Page`]: 0,
        [`${CategoryConstants.WINERY.uri}Page`]: 0
      },
      loading: true
    }

    this.updateQuery = this.updateQuery.bind(this);
    this.submitQuery = this.submitQuery.bind(this);
    this.handleScroll = this.handleScroll.bind(this);
  }

  componentDidMount() {
    this.props.fetchResultsAction({
        pageNumber: this.state.page.Page,
        category: this.state.activeTab,
        query: this.state.query
    }).then( result => {} // TBD: Handle pageNumber Update
    );
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (prevProps.location.pathname !== this.props.location.pathname) {
      this.setState({activeTab: this.props.location.pathname.substring(1)});
    }
  }

  handleScroll = params => debounce(e => {
    const fetch = e.target.scrollHeight - e.target.scrollTop === e.target.clientHeight
    if (fetch) {
      this.props.fetchResultsAction(params).then( result => {}) // TBD: Handle pageNumber Update
    }
  }, 100);

  updateQuery = (e) => {
    e.preventDefault();
    this.setState({query: e.target.value})
  }

  submitQuery = (e) => {
    e.preventDefault();
    return null;
  }

  render() {
    const { query, activeTab, page} = this.state;
    const pageNumber = page[`${activeTab}Page`]

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
            />
          </div>
        </div>
        <ReviewList
          handleScroll={this.handleScroll}
          params={{query, category: activeTab, pageNumber}}
        />
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    results: state.search
  }
}

const mapDispatchToProps = dispatch => {
  return {
    fetchResultsAction: fetchSearchResultsAction(dispatch)
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(Home);
