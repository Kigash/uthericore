report 50013 MemberApplicationForm
{
    ApplicationArea = All;
    Caption = 'MemberApplicationForm';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report/FOSA/MemberApplicationForm.rdl';
    dataset
    {
        dataitem(MemberApplication; "Member Application")
        {
            column(No; "No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(NationalID; "National ID")
            {
            }
            column(PINNo; "PIN No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(DateofRegistration; "Date of Registration")
            {
            }
            column(CurrentResidence; "Current Residence")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(CreatedDate; "Created Date")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(ApprovedDate; "Approved Date")
            {
            }
            column(Status; Status)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            dataitem(NexOfKin; "Beneficiary Type")
            {
                DataItemLink = "Application No." = field("No.");
                DataItemTableView = WHERE(Type = FILTER("Next of Kin"));
                column(NokName; Name)
                {
                }
                column(NokDOB; NexOfKin."Date of Birth")
                {
                }
                column(NokNationalID; NexOfKin."National ID")
                {
                }
                column(NokPhoneNo; NexOfKin."Phone No.")
                {
                }
                column(Relationship; NexOfKin.Relationship)
                {
                }
                column(Description; NexOfKin.Description)
                {
                }
            }
            dataitem(Nominee; "Beneficiary Type")
            {
                DataItemLink = "Application No." = field("No.");
                DataItemTableView = WHERE(Type = FILTER(Nominee));
                column(NomineeName; Nominee.Name)
                {
                }
                column(NomineeDOB; Nominee."Date of Birth")
                {
                }
                column(NomNationalID; Nominee."National ID")
                {
                }
                column(NomineePhoneNo; Nominee."Phone No.")
                {
                }
                column(NomAllocation; Nominee."Allocation (%)")
                {
                }
            }
            dataitem("Member Contribution"; "Member Contribution")
            {
                DataItemLink = "Application No." = field("No.");
                column(MCAccountType; "Account Type")
                {
                }
                column(MCDescription; Description)
                {
                }
                column(Amount; Amount)
                {
                }
            }
            dataitem("Member Bank Account"; "Member Bank Account")
            {
                DataItemLink = "Member No." = field("No.");
                column(MBBankCode; "Bank Code")
                {
                }
                column(MBBankName; "Bank Name")
                {
                }
                column(MBBranchCode; "Branch Code")
                {
                }
                column(MBBranchName; "Branch Name")
                {
                }
                column(MBAccountNo; "Account No.")
                {
                }
                column(Default; Default)
                {
                }
            }

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    labels
    {
        ReportTitle = 'Member Application Form';
    }
    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
