pageextension 50493 "Employee Extension" extends "Employee Card"
{
    layout
    {

        modify("Search Name")
        {
            Visible = false;
        }
        modify(Initials)
        {
            Visible = false;
        }
        modify("Alt. Address Code")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Alt. Address End Date")
        {
            Visible = false;
        }
        modify("Alt. Address Start Date")
        {
            Visible = false;
        }

        addafter("Union Membership No.")
        {
            field("PIN Number"; Rec."PIN Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("PIN Number")
        {
            field("National ID"; Rec."National ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("National ID")
        {
            field(NSSF; Rec.NSSF)
            {
                ApplicationArea = All;
            }
        }
        addafter(NSSF)
        {
            field(NHIF; Rec.NHIF)
            {
                ApplicationArea = All;
            }
        }
        addafter(NHIF)
        {
            field("Passport Number"; Rec."Passport Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("Passport Number")
        {
            field("HELB No."; Rec."HELB No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Company E-Mail")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }

        addafter("Global Dimension 1 Code")
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
        }


        addafter(Control7)
        {
            field("Employee Type"; Rec."Employee Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Employee Type")
        {
            field("Employee Status"; Rec."Employee Status")
            {
                ApplicationArea = All;
            }
        }

        addafter("Birth Date")
        {
            field(Age; Rec.Age)
            {
                ApplicationArea = All;
            }
        }
        addafter(Age)
        {
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = All;
            }
        }
        addafter("Marital Status")
        {
            field("Blood Type"; Rec."Blood Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Blood Type")
        {
            field(Disability; Rec.Disability)
            {
                ApplicationArea = All;
            }
        }
        addafter("Bank Branch No.")
        {
            field("Member No."; Rec."Member No.")
            {
                ApplicationArea = All;
            }
        }

        addafter("Employment Date")
        {
            field("Probation Period"; Rec."Probation Period")
            {
                ApplicationArea = All;
            }
        }

        addafter("Probation Period")
        {
            field("Probation End Date"; Rec."Probation End Date")
            {
                ApplicationArea = All;
            }
        }

        addafter("Probation End Date")
        {
            field("Extend Probation Period"; Rec."Defer Confirmation")
            {
                ApplicationArea = All;
            }
        }
        addafter("Extend Probation Period")
        {
            field("Extension Duration"; Rec."Extension Duration")
            {
                ApplicationArea = All;
            }
        }
        addafter("Extension Duration")
        {
            field("Reason For Extension"; Rec."Reason For Extension")
            {
                ApplicationArea = All;
            }
        }

        addafter("Reason For Extension")
        {
            field("Certificate No."; Rec."Certificate No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Certificate No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reference No.")
        {
            field("Date of Certificate"; Rec."Date of Certificate")
            {
                ApplicationArea = All;
            }
        }
        addafter("Date of Certificate")
        {
            field("Confirmation Status"; Rec."Confirmation Status")
            {
                ApplicationArea = All;
            }
        }

        addafter("Confirmation Status")
        {
            field("Confirmation/Dismissal Date"; Rec."Confirmation/Dismissal Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Confirmation/Dismissal Date")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }

        addafter("HELB No.")
        {
            field("Annual Leave Earned"; Rec."Annual Leave Earned")
            {
                ApplicationArea = All;
            }
        }

        addafter("Annual Leave Earned")
        {
            field("Annual Leave Taken"; Rec."Annual Leave Taken")
            {
                ApplicationArea = All;
            }
        }

        addafter("Annual Leave Taken")
        {
            field("Annual Leave Balance"; Rec."Annual Leave Balance")
            {
                ApplicationArea = All;
            }
        }

        addafter("Annual Leave Balance")
        {
            field("Lost Days"; Rec."Lost Days")
            {
                ApplicationArea = All;
            }
        }

        movebefore("Inactive Date"; Status)
        movefirst(Control13; "Phone No.2")

        moveafter("E-Mail"; "Company E-Mail")
        moveafter("Company E-Mail"; "Employment Date")

        modify(Pager)
        {
            Visible = false;
        }


    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Rec.Validate("Annual Leave Balance");
    end;
}