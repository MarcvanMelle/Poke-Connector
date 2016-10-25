import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class NewRequest extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: [],
      selectedPokemon: '',
      level: 0,
      desc: ''
    }
    this.handleFieldChange = this.handleFieldChange.bind(this);
    this.handleRequestSubmission = this.handleRequestSubmission.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    let _this = this

    $.ajax({
      url: '/api/v1/requests/new',
      contentType: 'application/json'
    }).done(data => {
      if(data.user){
        _this.setState({ pokemon: data.pokemon });
      } else {
        _this.context.router.push("/users/sign_in")
      }
    });
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
      url: '/api/v1/requests/',
      type: 'POST',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        requests: {
          pokemon: _this.state.selectedPokemon,
          description: _this.state.desc
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

    let selectOptions = this.state.pokemon.map(pokemon => {
      return (
        <option value={pokemon}>{pokemon}</option>
      );
    });

    return (
      <div>
        <div className="row page-head">
          <div className="columns small-12">
            <h1>Request a new Pokemon</h1>
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

        <form className="new-request" onSubmit={this.handleRequestSubmission}>
          <div className="row">
            <div className="columns small-7">
              <label>Pokemon:</label>
              <select name="selectedPokemon" id="poke-select" onChange={this.handleFieldChange}>
                {selectOptions}
              </select>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-8 float-left">
              <label>Description:</label>
              <textarea name="desc" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row button-row submit-zone">
            <div className="submit columns small-7">
              <input className="button" type="submit" value="Submit Request"/>
            </div>
          </div>
        </form>
      </div>
    );
  }
}

NewRequest.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default NewRequest
