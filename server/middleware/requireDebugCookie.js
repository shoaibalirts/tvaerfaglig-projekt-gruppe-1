const requireDebugCookie = (req, res, next) => {
  console.log("Cookies received:", req.cookies);

  if (!req.cookies.token) {
    return res.status(403).json({
      success: false,
      msg: "Access denied. cookie token_debug not found.",
    });
  }

  next(); // cookie exists → allow route
};
export default requireDebugCookie;
