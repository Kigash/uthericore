page 50394 "InterTeller Transfer"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "InterTeller Transfer Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
            }
            part("InterTeller Transfer Subform"; "InterTeller Transfer Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /*   action(ActionName)
              {
                  ApplicationArea = All;

                  trigger OnAction()
                  begin

                  end;
              } */
        }
    }

    var
        myInt: Integer;
}