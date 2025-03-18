using System.ComponentModel.DataAnnotations;

namespace minimalAPi_sample.models
{
    public class User
    {
        [Key]
        public string username {  get; set; }
        public string password { get; set; }
            }
}
