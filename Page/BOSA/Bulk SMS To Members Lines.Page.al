page 54386 "Bulk SMS To Members Lines"
{
    PageType = CardPart;
    SourceTable = "Bulk SMS Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Owner Member No"; Rec."Owner Member No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Member No';
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Member Name';
                }
                field("Owner Phone No"; Rec."Owner Phone No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Phone No.';
                }
                field(Select; Rec.Select)
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
            group("Actions")
            {
                Caption = 'Actions';
                Image = Setup;
                action("Select All")
                {
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        BulkSMSLine.RESET;
                        BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."Document No");
                        if BulkSMSLine.FINDSET then begin
                            repeat
                                BulkSMSLine.Select := true;
                                BulkSMSLine.MODIFY;
                            until BulkSMSLine.NEXT = 0;
                        end;
                    end;
                }
                action("Un Select All")
                {
                    Image = SelectLineToApply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    begin
                        BulkSMSLine.RESET;
                        BulkSMSLine.SETRANGE(BulkSMSLine."Document No", Rec."Document No");
                        if BulkSMSLine.FINDSET then begin
                            repeat
                                BulkSMSLine.Select := false;
                                BulkSMSLine.MODIFY;
                            until BulkSMSLine.NEXT = 0;
                        end;
                    end;
                }
            }
        }
    }

    var
        BulkSMSLine: Record "Bulk SMS Line";
}

