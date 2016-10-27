import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class EditPokeball extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: {},
      pokeball: {},
      level: 0,
      description: '',
      hpIV: '',
      attIV: '',
      defIV: '',
      spaIV: '',
      spdIV: '',
      speIV: ''
    }
    this.handleFieldChange = this.handleFieldChange.bind(this)
    this.handlePokeballSubmission = this.handlePokeballSubmission.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: '/api/v1/pokeballs/' + this.props.params.pokeballId + "/edit"
    }).done(data => {
      this.setState({
        pokemon: data.pokemon,
        pokeball: data.pokeball,
        level: data.pokeball.level,
        description: data.pokeball.description,
        hpIV: data.pokeball.hpIV,
        attIV: data.pokeball.attIV,
        defIV: data.pokeball.defIV,
        spaIV: data.pokeball.spaIV,
        spdIV: data.pokeball.spdIV,
        speIV: data.pokeball.speIV
      })
    })
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
      url: '/api/v1/pokeballs/' + _this.state.pokeball.id,
      type: 'PATCH',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({
        pokeballs: {
          level: _this.state.level,
          description: _this.state.description,
          hpIV: _this.state.hpIV,
          attIV: _this.state.attIV,
          defIV: _this.state.defIV,
          spaIV: _this.state.spaIV,
          spdIV: _this.state.spdIV,
          speIV: _this.state.speIV
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
        <div className="row page-head text-center">
          <div className="columns small-12">
            <h1>Change Your Pokemon Offer</h1>
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

        <form className="edit-pokeball" onSubmit={this.handlePokeballSubmission}>
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

          <div className="row">
            <div className="field columns small-3 float-left">
              <label className="inline">Level:</label>
              <em>(1-100)</em>
              <input name="level" value={this.state.level} onChange={this.handleFieldChange} type="number"/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-3 float-left">
              <label className="inline">HP IV:</label>
              <em>(0-31)</em>
              <input name="hpIV" value={this.state.hpIV} onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-3 float-left">
              <label className="inline">Atk IV:</label>
              <em>(0-31)</em>
              <input name="attIV" value={this.state.attIV} onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-3 float-left">
              <label className="inline">Def IV:</label>
              <em>(0-31)</em>
              <input name="defIV" value={this.state.defIV} onChange={this.handleFieldChange} type="number"/>
            </div>
          </div>

          <div className="row">
            <div className="field columns small-3 float-left">
              <label className="inline">SpA IV:</label>
              <em>(0-31)</em>
              <input name ="spaIV" value={this.state.spaIV} onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-3 float-left">
              <label className="inline">SpD IV:</label>
              <em>(0-31)</em>
              <input name="spdIV" value={this.state.spdIV} onChange={this.handleFieldChange} type="number"/>
            </div>

            <div className="field columns small-3 float-left">
              <label className="inline">Spe IV:</label>
              <em>(0-31)</em>
              <input name="speIV" value={this.state.speIV} onChange={this.handleFieldChange} type="number"/>
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

EditPokeball.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default EditPokeball
