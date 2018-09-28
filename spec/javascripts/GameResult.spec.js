import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import GameResult from 'components/GameResult'

describe('GameResult.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(GameResult, {
      propsData: {
        gameResult: 'incomplete'
      }
    })
  })

  it('indicates when the game is tied', () => {
    wrapper.setProps({
      gameResult: 'tie'
    })
    expect(wrapper.text()).toBe('Tie game!')
  })

  it('indicates when player one has won', () => {
    wrapper.setProps({
      gameResult: '1'
    })
    expect(wrapper.text()).toBe('Player 1 wins!')
  })

  it('indicates when player two has won', () => {
    wrapper.setProps({
      gameResult: '2'
    })
    expect(wrapper.text()).toBe('Player 2 wins!')
  })

  it('is blank when the game is incomplete', () => {
    wrapper.setProps({
      gameResult: 'incomplete'
    })
    expect(wrapper.text()).toBe('')
  })
})
