import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/wine" exact component={Home} />
      <Route path="/variety" exact component={Home} />
      <Route path="/taster" exact component={Home} />
      <Route path="/winery" exact component={Home} />
    </Switch>
  </Router>
);
