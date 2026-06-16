page 50441 "HR Documents View"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Human Resource Document";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        if Rec."Document Reference ID".HasValue then
                            Rec.Export(true)
                    end;
                }
                field("Attached By"; Rec."Attached By")
                {
                    ApplicationArea = All;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Get a preview of the attachment.';

                trigger OnAction()
                begin
                    if Rec."File Name" <> '' then
                        Rec.Export(true);
                end;
            }
        }
    }
}
