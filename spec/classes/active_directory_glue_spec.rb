require 'spec_helper'

describe 'active_directory_glue', :type => 'class' do
    
  context "Should include krb5, samba and sssd service" do
    let(:facts) { {:operatingsystem => 'CentOS'} }
  
    it do
      should contain_class('krb5')
      should contain_class('samba')
      should contain_class('sssd')
      
      should contain_class('krb5::authenticate').that_comes_before("Class[samba::adsjoin::kerberos]")
      should contain_class('samba::adsjoin::kerberos').that_comes_before("Class[sssd::authconfig]")
      should contain_class('sssd::authconfig').that_notifies("Service[sssd]")
    end
  end
end
