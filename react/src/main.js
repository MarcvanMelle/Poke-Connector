import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom'
import routes from './components/routes'
import { Router, Route, browserHistory } from 'react-router'

$(function() {
  ReactDOM.render(
    <Router history={browserHistory} routes={routes}/>,
    document.getElementById('app')
  );
});
