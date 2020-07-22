import React from "react";
import { Link } from "react-router-dom";

const Home = () => (
    <div>
    	Hello Muppet
        <Link
          to="/recipes"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Recipes
        </Link>
      </div>
);

export default Home;
