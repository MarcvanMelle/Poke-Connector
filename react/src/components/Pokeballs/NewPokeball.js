import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class NewPokeball extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: [],
      selectedPokemon: '',
      level: 0,
      desc: '',
      hp: '',
      atk: '',
      def: '',
      spa: '',
      spd: '',
      spe: ''
    }
    this.handleFieldChange = this.handleFieldChange.bind(this);
    this.handlePokeballSubmission = this.handlePokeballSubmission.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    let _this = this

    $.ajax({
      url: '/api/v1/pokeballs/new',
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

  handlePokeballSubmission(e) {
    e.preventDefault();
    let _this = this
    $.ajax({
      url: '/api/v1/pokeballs/',
      type: 'POST',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        pokeballs: {
          pokemon: _this.state.selectedPokemon,
          level: _this.state.level,
          description: _this.state.desc,
          hpIV: _this.state.hp,
          attIV: _this.state.atk,
          defIV: _this.state.def,
          spaIV: _this.state.spa,
          spdIV: _this.state.spd,
          speIV: _this.state.spe
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

    selectOptions.unshift(<option value="">Choose a Pokemon</option>)

    return (
      <div>
        <div className="row page-head text-center">
          <div className="columns small-12">
            <h1>Offer a new Pokemon</h1>
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

        <form className="new-pokeball" onSubmit={this.handlePokeballSubmission}>
          <div className="row">
            <div className="columns small-7">
              <label>Pokemon:</label>
              <select name="selectedPokemon" id="poke-select" onChange={this.handleFieldChange}>
                {selectOptions}
              </select>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-4 float-left">
              <label className="inline">Level:</label>
              <em>(1-100)</em>
              <input name="level" onChange={this.handleFieldChange} type="number"/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-8 float-left">
              <label>Description:</label>
              <textarea name="desc" onChange={this.handleFieldChange}/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-4 float-left">
              <label className="inline">HP IV:</label>
              <em>(0-31)</em>
              <input name="hp" onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-4 float-left">
              <label className="inline">Atk IV:</label>
              <em>(0-31)</em>
              <input name="atk" onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-4 float-left">
              <label className="inline">Def IV:</label>
              <em>(0-31)</em>
              <input name="def" onChange={this.handleFieldChange} type="number"/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-4 float-left">
              <label className="inline">SpA IV:</label>
              <em>(0-31)</em>
              <input name ="spa" onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-4 float-left">
              <label className="inline">SpD IV:</label>
              <em>(0-31)</em>
              <input name="spd" onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-4 float-left">
              <label className="inline">Spe IV:</label>
              <em>(0-31)</em>
              <input name="spe" onChange={this.handleFieldChange} type="number"/>
            </div>
          </div>

          <div className="row button-row submit-zone">
            <div className="submit columns small-7">
              <input className="button" type="submit" value="Submit Offer"/>
            </div>
          </div>
        </form>
      </div>
    );
  }
}

NewPokeball.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default NewPokeball
