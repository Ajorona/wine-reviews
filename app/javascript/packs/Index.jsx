import React from 'react';
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux';
import { render } from 'react-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.bundle.min';

import App from '../components/App';
import RootReducer from '../reducers/RootReducer';

document.addEventListener('DOMContentLoaded', () => {
  render(
    <Provider store={createStore(RootReducer)}>
      <App />
    </Provider>,
    document.body.appendChild(document.createElement('div'))
  );
});
