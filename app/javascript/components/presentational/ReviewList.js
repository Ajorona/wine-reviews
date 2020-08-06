import React from "react";

import ReviewCard from './ReviewCard';

const ReviewList = ({
  handleScroll, params
}) => {
  return (
      <div onScroll={handleScroll(params)}>
        <ReviewCard />
      </div>
  )
}

export default ReviewList;
