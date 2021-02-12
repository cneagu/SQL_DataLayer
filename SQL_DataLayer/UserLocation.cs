using System;

namespace DataLayer_Test
{
    public class UserLocation
    {
        #region Properties
        public Guid UserID { get; set; }
        public string Country { get; set; }
        public string County { get; set; }
        public string City { get; set; }
        #endregion
    }
}
