using System;

namespace DataLayer_Test
{
    public class User
    {
        #region Properties
        public Guid UserID { get; set; }
        public string Email { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public DateTime CreationDate { get; set; }
        public bool Subscribed { get; set; }
        #endregion
    }
}
