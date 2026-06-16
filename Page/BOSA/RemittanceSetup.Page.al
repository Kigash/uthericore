page 50298 "Remittance Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Remittance Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {

                field("Member Remittance Advice Nos."; Rec."Member Remittance Advice Nos.")
                {
                    ApplicationArea = All;
                }

                field("Agency Remittance Advice Nos."; Rec."Agency Remittance Advice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Rem. G/L Control Account"; Rec."Rem. G/L Control Account")
                {
                    ApplicationArea = All;
                }
                field("Rem. Bank Control Account"; Rec."Rem. Bank Control Account")
                {
                    ApplicationArea = All;
                }
            }
            group(External)
            {
                Caption = 'External';
                field("SQL Server"; Rec."SQL Server")
                {
                    ApplicationArea = All;
                }
                field("SQL Database"; Rec."SQL Database")
                {
                    ApplicationArea = All;
                }
                field("SQL User ID"; Rec."SQL User ID")
                {
                    ApplicationArea = All;
                }
                field("SQL Password"; Rec."SQL Password")
                {
                    ApplicationArea = All;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }
                field("Email Template"; Rec."Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template"; Rec."SMS Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

