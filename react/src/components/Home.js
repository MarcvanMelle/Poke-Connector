import React from 'react'
import { Link } from 'react-router'

const Home = React.createClass({

  render() {
    return (
      <div>
        <div className="row home-bar">
          <div className="columns small-12">
            <Link to="/" activeClassName="active" className="button">Home</Link>
            <Link to="/pokeballs/new" activeClassName="active" className="button">Offer a Pokemon</Link>
            <Link to="/requests/new" activeClassName="active" className="button">Request a Pokemon</Link>
            <Link to="/pokeballs" activeClassName="active" className="button">All Open Offers</Link>
            <Link to="/requests" activeClassName="active" className="button">All Open Requests</Link>
          </div>
        </div>
        <div className="home-barrier"></div>
        {this.props.children}
      </div>
    )
  }
})

export default Home
