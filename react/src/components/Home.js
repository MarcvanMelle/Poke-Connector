import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class Home extends Component {
  constructor(props){
    super(props);
    this.state = {
      user: null
    }
    this.handleLogOut = this.handleLogOut.bind(this)
  }

  componentDidMount() {
    $.ajax({
      url: "/api/v1/pokemons"
    }).done(data => {
      this.setState({ user: data.user })
    })
  }

  handleLogOut(e) {
    e.preventDefault();
    let _this = this
    $.ajax({
      url: "/users/sign_out",
      type: "DELETE",
      success: function(){
        _this.context.router.push("/")
        location.reload();
      }
    })
  }

  render() {
    let currentUser, myProfile, logOut, signUp, logIn, forgotPW
    if (this.state.user) {
      currentUser = <h5 className="text-right">Signed in as {this.state.user.username}</h5>
      myProfile = <h5 className="text-right"><Link to={`/users/${this.state.user.id}`}>My Profile</Link></h5>
      logOut = <h5 className="text-right"><a href="/users/sign_out" onClick={this.handleLogOut}>Log Out</a></h5>
    } else {
      signUp = <h5 className="text-right"><Link to="/users/sign_up">Sign Up</Link></h5>
      logIn = <h5 className="text-right"><Link to="/users/sign_in">Log In</Link></h5>
      forgotPW = <h5 className="text-right"><a href="/users/password/new">Forgot your password?</a></h5>
    }

    return (
      <div>
        <div className="row nav-bar">
          <div className="columns small-12">
            {currentUser}
            {myProfile}
            {logOut}
            {signUp}
            {logIn}
            {forgotPW}
          </div>
        </div>
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
}

Home.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default Home
