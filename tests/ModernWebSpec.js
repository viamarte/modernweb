
describe('ModernWeb', function() {
  return describe('Detection framework', function() {
    return it('should be able to detect when a browser support Canvas (HTML5)', function() {
      return expect(ModernWeb.html5Compatible()).to.equal(true);
    });
  });
});
