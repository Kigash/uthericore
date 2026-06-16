page 56303 "Loan Notification Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Notification Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }

                field("First Notification Template"; Rec."First Notification Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Second Notification Template-Member"; Rec."Second Notification Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }

                field("Third Notification Template"; Rec."Third Notification Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Fourth Notification Template"; Rec."Fourth Notification Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("First Default Template"; Rec."First Default Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Second Default Template"; Rec."Second Default Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Third Default Template"; Rec."Third Default Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Fourth Default Template"; Rec."Fourth Default Template")
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

    trigger OnAfterGetRecord()
    begin
    end;

    var
        DemandLetterTemplate: Text;
}

