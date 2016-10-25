import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class EditRequest extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: {},
      request: {},
      description: ''
    }
    this.handleFieldChange = this.handleFieldChange.bind(this)
    this.handleRequestSubmission = this.handleRequestSubmission.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: '/api/v1/requests/' + this.props.params.requestId + "/edit"
    }).done(data => {
      this.setState({
        pokemon: data.pokemon,
        request: data.request,
        description: data.request.description
      })
    })
  }

  handleFieldChange(e) {
    let shift = {};
    shift[e.target.name] = e.target.value;
    this.setState(shift);
  }

  handleRequestSubmission(e) {
    e.preventDefault();
    let _this = this
    $.ajax({
      url: '/api/v1/requests/' + _this.state.request.id,
      type: 'PATCH',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        requests: {
          description: _this.state.description
        }
      }),
      success: function(data) {
        if (data.errors) {
          $(window).scrollTop(0);
          _this.setState({ errors: data.errors });
        } else {
          _this.context.router.push(data.path)
        }
      }
    });
  }

  render() {
    let errors;
    if(this.state.errors) {
      errors = <div>{this.state.errors}</div>
    } else {
      errors = <div></div>
    }

    return(
      <div>
        <div className="row page-head">
          <div className="columns small-12">
            <h1>Change Your Pokemon Request</h1>
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

        <form className="edit-request" onSubmit={this.handleRequestSubmission}>
          <div className="row">
            <div className="text-center columns small-3 small-pokediv">
              <img src={"/assets/" + this.state.pokemon.sprite} className="poke-sprite"/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-7">
              <label>Description</label>
              <textarea name="description" value={this.state.description} onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row button-row">
            <div className="submit columns small-7">
              <input value="Submit Changes" className="button" type="submit"/>
            </div>
          </div>
        </form>
      </div>
    )
  }
}

EditRequest.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default EditRequest
