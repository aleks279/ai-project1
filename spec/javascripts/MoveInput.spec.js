import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import MoveInput from 'components/MoveInput'

describe('MoveInput.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(MoveInput, {
      propsData: {
        moves: [],
        movesAllowed: true,
        gameResult: 'incomplete',
        currentPlayerType: 'human'
      }
    })
  })

  it('emits a "move" event when a column is clicked', () => {
    const stub = jest.fn()
    wrapper.vm.$on('move', stub)
    for (let i = 0; i < 7; i++) {
      wrapper.findAll('button').at(i).trigger('click')
      expect(stub).toBeCalledWith(i)
    }
  })

  it('disables a button when the column is full', () => {
    wrapper.setProps({
      moves: [0,0,0,0,0,0]
    })
    expect(wrapper.findAll('button').at(0).attributes().disabled).toBe('disabled')
  })

  it('disables all buttons when moves are not allowed', () => {
    wrapper.setProps({
      movesAllowed: false
    })
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe('disabled')
    }
  })

  it('disables all buttons when the game is tied', () => {
    wrapper.setProps({
      gameResult: 'tie'
    })
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe('disabled')
    }
  })

  it('disables all buttons when the game is won by player 1', () => {
    wrapper.setProps({
      gameResult: '1'
    })
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe('disabled')
    }
  })

  it('disables all buttons when the game is won by player 2', () => {
    wrapper.setProps({
      gameResult: '2'
    })
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe('disabled')
    }
  })

  it('disables all buttons when the current player is a computer', () => {
    wrapper.setProps({
      currentPlayerType: 'computer'
    })
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe('disabled')
    }
  })

  it('enables all buttons when the game is new', () => {
    for (let i = 0; i < 7; i++) {
      expect(wrapper.findAll('button').at(i).attributes().disabled).toBe(undefined)
    }
  })

  it('has the expected html structure', () => {
    expect(wrapper.element).toMatchSnapshot()
  })
})
