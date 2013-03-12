#Testing ModernWeb Core with Mocha
describe 'ModernWeb', ->
  describe 'Detection framework', ->
    it 'should be able to detect when a browser support Canvas (HTML5)', ->
      expect(ModernWeb.html5Compatible()).to.equal(true)