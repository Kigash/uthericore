page 50380 "Bulk SMS Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Bulk SMS Setup";

    layout
    {
        area(Content)
        {
            group(BulkSMS)
            {
                field("API Key"; Rec."API Key")
                {
                    ApplicationArea = All;

                }
                field("Short Code"; Rec."Short Code")
                {
                    ApplicationArea = All;

                }
                field("Partner ID"; Rec."Partner ID")
                {
                    ApplicationArea = All;

                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;

                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    /*  actions
     {
         area(Processing)
         {
             action(ActionName)
             {
                 ApplicationArea = All;

                 trigger OnAction()
                 begin

                 end;
             }
         }
     } */
    trigger OnAfterGetRecord()
    begin


    end;

    var
        myInt: Integer;
}