import { shallow } from 'vue-test-utils'
import Vue from 'vue'
import GameBoard from 'components/GameBoard'

describe('GameBoard.vue', () => {
  let wrapper

  beforeEach(() => {
    wrapper = shallow(GameBoard, {
      propsData: {
        moves: []
      }
    })
  })

  it('computes the board state correctly', () => {
    wrapper.setProps({
      moves: [0,1,0,1,3,3,3,3]
    })
    expect(wrapper.vm.boardState).toEqual([[".", ".", ".", ".", ".", ".", "."],
                                           [".", ".", ".", ".", ".", ".", "."],
                                           [".", ".", ".", "2", ".", ".", "."],
                                           [".", ".", ".", "1", ".", ".", "."],
                                           ["1", "2", ".", "2", ".", ".", "."],
                                           ["1", "2", ".", "1", ".", ".", "."]])
  })

  it('matches the snapshot', () => {
    wrapper.setProps({
      moves: [0,1,0,1,3,3,3,3]
    })
    expect(wrapper.element).toMatchSnapshot()
  })
})
