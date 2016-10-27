import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class UserSignUp extends Component {
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      first_name: '',
      last_name: '',
      email: '',
      password: '',
      password_confirmation: '',
      friend_code: ''
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
      url: "/api/v1/users",
      type: "POST",
      data: { user: {
                username: _this.state.username,
                first_name: _this.state.first_name,
                last_name: _this.state.last_name,
                email: _this.state.email,
                password: _this.state.password,
                password_confirmation: _this.state.password_confirmation,
                friend_code: _this.state.friend_code
              }
            },
      success: function(data) {
        if(data.errors){
          $(window).scrollTop(0);
          _this.setState({ errors: data.errors });
        } else {
          _this.context.router.push(data.path)
          location.reload();
        }
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
            <h2>Sign up</h2>
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
              <label>Username</label>
              <input type="text" name="username" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-4 float-left">
              <label>First Name</label>
              <input type="text" name="first_name" onChange={this.handleFieldChange}/>
            </div>

            <div className="columns small-4 float-left">
              <label>Last Name</label>
              <input type="text" name="last_name" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <label>Email</label>
              <input type="email" name="email" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <label className="inline">Password</label><em>(6 characters minimum)</em>
              <input autocomplete="off" type="password" name="password" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <label>Password Confirmation</label>
              <input autocomplete="off" type="password" name="password_confirmation" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="columns small-8">
              <label className="inline">Friend Code</label><em>(Recommended)</em>
              <input type="text" name="friend_code" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row button-row">
            <div className="columns small-4">
              <input value="Sign Up" className="button" type="submit"/>
            </div>
          </div>
        </form>


      </div>
    )
  }
}

UserSignUp.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default UserSignUp
