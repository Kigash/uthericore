page 55001 "Loan Officer Setup"
{
    // version MC2.0

    PageType = List;
    SourceTable = "Loan Officer Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Supervisor"; Rec."Supervisor")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

