import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class UserSignIn extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      password: '',
      remember_me: 'off'
    }
    this.handleFieldChange = this.handleFieldChange.bind(this)
    this.handleRegistrationSubmit = this.handleRegistrationSubmit.bind(this)
  }

  handleFieldChange(e) {
    let shift = {};
    shift[e.target.name] = e.target.value;
    this.setState(shift);
  }

  handleRegistrationSubmit(e) {
    e.preventDefault();
    let _this = this
    $.ajax({
      url: "/users/sign_in",
      type: "POST",
      data: { user: {
          email: _this.state.email,
          password: _this.state.password
        }
      },
      success: function() {
        _this.context.router.push("/")
        location.reload();
      },
      error: function() {
        _this.setState({ errors: "User name or password incorrect." })
      }
    })
  }

  render(){

    $("#not-app").hide();

    let errors;
    if(this.state.errors) {
      errors = <div>{this.state.errors}</div>
    } else {
      errors = <div></div>
    }

    return(
      <div>

        <div className="row page-head text-center">
          <div className="columns small-12">
            <h2>Log In</h2>
          </div>
        </div>

        <div className="row">
          <div className="columns-12 flash-bar text-center">
            {errors}
          </div>
        </div>


        <div className="row search-bar">
          <div className="columns small-12">

          </div>
        </div>

        <form onSubmit={this.handleRegistrationSubmit}>

          <div className="row">
            <div className="columns small-8">
              <label>Email</label>
              <input placeholder="e.g. pokemaster@example.com" type="email" name="email" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <label className="inline">Password</label>
              <input placeholder="Your password here" autocomplete="off" type="password" name="password" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <input name="remember_me" type="checkbox" onChange={this.handleFieldChange}/>
              <label>Remember Me</label>
            </div>
          </div>


          <div className="row button-row">
            <div className="columns small-4">
              <input value="Log In" className="button" type="submit"/>
            </div>
          </div>
        </form>


      </div>
    )
  }
}

UserSignIn.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default UserSignIn
