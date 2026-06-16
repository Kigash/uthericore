pageextension 50501 "Payroll Setup Ext" extends "Payroll Setup"
{
    layout
    {
        addafter("General Journal Batch Name")
        {
            field("Payroll Roundoff"; Rec."Payroll Roundoff")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Tax Roundoff"; Rec."Tax Roundoff")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Pension Cap"; Rec."Pension Cap")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Insurance Relief Cap"; Rec."Insurance Relief Cap")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Owner Occupier"; Rec."Owner Occupier")
            {
                ApplicationArea = Basic, Suite;
            }
            field("NSSF Code"; Rec."NSSF Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("NHIF Code"; Rec."NHIF Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Employer NSSF No."; Rec."Employer NSSF No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Employer NHIF No."; Rec."Employer NHIF No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Provident Fund Code (Employee)"; Rec."Provident Fund Code (Employee)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Provident Fund Code (Employer)"; Rec."Provident Fund Code (Employer)")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Duty Allowance Code"; Rec."Duty Allowance Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Bonus Code"; Rec."Bonus Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Arrears Code"; Rec."Arrears Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("House Allowance Code"; Rec."House Allowance Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Transport Allowance Code"; Rec."Transport Allowance Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("HELB Code"; Rec."HELB Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Salary Advance Code"; Rec."Salary Advance Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Apply 1/3 Rule?"; Rec."Apply 1/3 Rule?")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Paying Account Type"; Rec."Paying Account Type")
            {
                ApplicationArea = Basic, Suite;
            }
            group(PayingBankAccount)
            {
                Visible = Rec."Paying Account Type" = 1;
                Caption = '';
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(NetPay)
            {
                Visible = Rec."Paying Account Type" = 2;
                Caption = '';
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}